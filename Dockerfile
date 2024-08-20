# Use a Debian-based Ruby image as a parent image, specifying version 3.0.5
FROM ruby:3.0.5-buster

# Install Python 3.7 or higher
RUN apt-get update && \
    apt-get install -y python3.7 python3.7-venv python3.7-dev && \
    ln -sf /usr/bin/python3.7 /usr/bin/python3 && \
    ln -sf /usr/bin/python3.7 /usr/bin/python

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Set up a Python virtual environment and install PDM
RUN python3 -m venv /app/venv && \
    /app/venv/bin/pip install --upgrade pip && \
    /app/venv/bin/pip install "pdm>=2.17"

# Install the specified version of Bundler and Ruby dependencies
RUN gem install bundler -v 2.3.22 && \
    bundle install --jobs=4 --retry=3
    
# Install Node.js dependencies using the Ruby rake task
RUN source /app/venv/bin/activate && bundle exec rake install

# Expose port 3000 to the host
EXPOSE 3000

# Define the command to run your application
CMD ["/bin/bash", "-c", "source /app/venv/bin/activate && ./bin/dashboard-server"]