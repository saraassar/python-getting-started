# Base image
FROM python:3.13-slim

# Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1

# Ensure Python output is sent straight to the terminal
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Copy only the requirements first (better Docker layer caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose the application port
EXPOSE 8000

# Start the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
