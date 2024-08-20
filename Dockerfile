# Use an official Ruby image as a parent image, specifying version 3.0.5
FROM amd64/ruby:3.0.5

# Install Node.js 18.16.0 and Python 3 (with virtual environment support)
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs=18.16.0-1nodesource1 python3 python3-venv

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Set up a Python virtual environment and install PDM
RUN python3 -m venv /app/venv && \
    /app/venv/bin/pip install --upgrade pip && \
    /app/venv/bin/pip install "pdm>=2.17"

# Install the specified version of Bundler and Ruby dependencies
RUN gem install bundler -v 2.3.22 && bundle install

# Install Node.js dependencies using the Ruby rake task
RUN /bin/bash -c "source /app/venv/bin/activate && bundle exec rake install"

# Expose port 3000 to the host
EXPOSE 3000

# Define the command to run your application
CMD ["/bin/bash", "-c", "source /app/venv/bin/activate && ./bin/dashboard-server"]