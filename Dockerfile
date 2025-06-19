ARG AIRFLOW_IMAGE_NAME
FROM ${AIRFLOW_IMAGE_NAME}

# Install UV Python Package Manager
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Copy files containing dependencies
COPY pyproject.toml /opt/airflow/
COPY setup.py /opt/airflow/

# Copy source code
COPY src/ /opt/airflow/src/

# Install Python dependencies
RUN uv pip install "apache-airflow==${AIRFLOW_VERSION}" --no-cache-dir \
    apache-airflow-providers-postgres \
    apache-airflow-providers-redis \
    apache-airflow-providers-fab \
    apache-airflow-providers-celery
RUN uv pip install -r pyproject.toml --group prod
RUN uv pip install -e .
