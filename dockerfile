# Set the base image to use
FROM ruby:2.7.4

# Set the working directory to /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the dependencies using Bundler
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the rest of the application code into the container
COPY . .

# Set the Rails environment
ENV RAILS_ENV=development

# Create the database
RUN bundle exec rake db:create

# Run the database migrations
RUN bundle exec rake db:migrate

# Expose port 3000 for the Rails server
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]


