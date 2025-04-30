# Use an official Python image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Copy all files into the container
COPY . .

# Install dependencies
RUN pip install --upgrade pip \
    && pip install -r req.txt

# Run tests
CMD ["pytest", "test_app.py"]
