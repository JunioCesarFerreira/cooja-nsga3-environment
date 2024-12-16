FROM python:3.8-slim

# Atualizações e dependências básicas
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copiar scripts e requirements
WORKDIR /app
COPY scripts/ ./scripts/
COPY scripts/requirements.txt ./requirements.txt

# Instalar dependências
RUN pip install --no-cache-dir -r requirements.txt

# Expor porta para comunicação, se necessário
EXPOSE 5000

# Comando padrão
CMD ["python", "scripts/script_socket_layer.py"]
