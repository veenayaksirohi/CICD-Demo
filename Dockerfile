# Stage 1: Build and Test
FROM python:3.11-slim AS test
WORKDIR /app

# Install dependencies
COPY req.txt .
RUN pip install --no-cache-dir -r req.txt

# Copy application and test files
COPY . .

# Start Flask app in the background and run tests
RUN python app.py & \
    sleep 5 && \
    pytest -v -s 

CMD ["sh", "-c", "python app.py & sleep 5 && pytest -v -s"]

# Stage 2: Production
FROM python:3.11-slim AS runtime
WORKDIR /app

# Install dependencies
COPY req.txt .
RUN pip install --no-cache-dir -r req.txt

# Copy only the application code
COPY app.py .

# Expose the Flask port
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "app.py"]
