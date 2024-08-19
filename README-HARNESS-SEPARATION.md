# Harness Separation Strategy for code-dot-org repo

## Overview

This document outlines the strategy for decoupling the Code.org codebase into modular components, each serving a specific function. The goal is to create a minimal, harness-less version of the Code.org application that can be deployed independently by third-party entities, such as school districts. The modular design will allow users to selectively integrate curriculum, localization, and additional functionalities as needed while separating the core application from the marketing site and the proprietary Code.org operational harness.

## Repositories

1. **harnessless-code-dot-org/**: This is the core repository containing the barebones Learning Management System (LMS) without any Code.org-specific harnesses or business logic. It includes only the essential functionalities necessary to run the LMS, such as user account management, curriculum loading, and basic application services. This repository is designed to be the minimal deployable unit for external entities.

2. **curriculum-content/**: This repository contains the curriculum modules that can be imported into the harnessless-code-dot-org application. The curriculum is decoupled from the core application to allow districts to selectively load and manage the curriculum they wish to offer.

3. **locale-content/**: This repository houses localization files for the application. Most users will only need a single locale, so these are separated into their own module to avoid unnecessary overhead in deployments. The locale-content repository allows users to add or modify language support as needed.

4. **marketing-code-dot-org/**: This repository contains the Code.org marketing site, which is entirely separated from the core LMS. The marketing site has no dependencies on the harnessless-code-dot-org application and can be managed independently. It includes all functionalities related to Code.org's public-facing marketing efforts, such as teacher recruitment, professional development promotions, and other outreach initiatives.

5. **code-dot-org-harness/**: This repository contains the proprietary Code.org operational harness. It includes all the business-specific logic, third-party service integrations (e.g., New Relic, Amplitude, Honeybadger), and internal tools required to run the Code.org platform at scale. This harness is designed to be plugged into the harnessless-code-dot-org application or run as part of a larger infrastructure managed by Code.org. The harness includes tools for parallelization, cron jobs for maintenance, and the entire operational setup that keeps Code.org running efficiently.

## Modular Breakdown and Separation

### 1. **Core Application (harnessless-code-dot-org)**
   - **Objective**: Create a minimal, deployable LMS application stripped of Code.org's business logic.
   - **Inclusions**:
     - User account management and authentication.
     - Ability to load and run curriculum from the curriculum-content repository.
     - Basic application services needed for LMS functionality.
   - **Exclusions**:
     - Marketing site references.
     - Professional development tools and teacher recruitment functions
     - Lead generation tools: anything Foorm, or Donor related
     - Code.org-specific operational tools (e.g., analytics, error tracking).
     - Census, surveys, and data science tools for internal reporting.

### 2. **Curriculum Module (curriculum-content)**
   - **Objective**: Separate the curriculum from the core LMS application, allowing external entities to load and manage their desired curriculum independently.
   - **Inclusions**:
     - All Code.org curriculum, formatted for easy import into the LMS.
   - **Modularity**:
     - Curriculum can be selectively loaded based on the needs of the user.

### 3. **Localization Module (locale-content)**
   - **Objective**: Provide localized content as an optional module for users who require support for languages other than English.
   - **Inclusions**:
     - Locale files for supported languages.
   - **Modularity**:
     - Users can add or modify language support by importing the relevant locale files.

### 4. **Marketing Site (marketing-code-dot-org)**
   - **Objective**: Fully decouple the marketing site from the LMS to allow independent operation and development.
   - **Inclusions**:
     - Public-facing website content.
     - Teacher recruitment and professional development promotions.
   - **Exclusions**:
     - Dependencies on the core LMS or operational harness.

### 5. **Operational Harness (code-dot-org-harness)**
   - **Objective**: Maintain all Code.org-specific operational logic, tools, and third-party integrations in a separate harness that can be optionally integrated with the LMS.
   - **Inclusions**:
     - Third-party analytics (e.g., New Relic, Amplitude).
     - Error tracking (e.g., Honeybadger).
     - Code.org-specific cron jobs and parallelization tools.
     - Census, surveys, and internal data science tools.
   - **Exclusions**:
     - None, as this harness is intended to contain all business-specific logic and tools.

## Development Plan

1. **Initial Separation**:
   - Extract the core LMS from the existing Code.org repository into harnessless-code-dot-org.
   - Identify and remove any Code.org-specific business logic, placing stubs where necessary.

2. **Curriculum and Localization**:
   - Move all curriculum content to the curriculum-content repository.
   - Separate locale files into the locale-content repository.

3. **Marketing Site Decoupling**:
   - Fully extract the marketing site into the marketing-code-dot-org repository.
   - Ensure no cross-dependencies remain between the marketing site and the LMS.

4. **Harness Implementation**:
   - Create the code-dot-org-harness repository, containing all proprietary business logic, third-party integrations, and operational tools.
   - Ensure that the harness can be optionally integrated with the harnessless LMS or run as part of Code.org's infrastructure.

## Conclusion

This modular approach allows Code.org to maintain a clean separation between its core application, curriculum, localization, marketing efforts, and proprietary operational harness. By decoupling these components, external entities can more easily deploy and manage the LMS while Code.org retains control over its business-specific functionalities.
