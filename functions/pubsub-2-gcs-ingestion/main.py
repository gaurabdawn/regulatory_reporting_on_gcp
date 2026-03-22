import base64
import json
from google.cloud import storage

def pubsub_to_gcs(event, context):
    print("Function triggered")

    try:
        message_data = base64.b64decode(event['data']).decode('utf-8')
        print(f"Decoded message: {message_data}")

        # ✅ Skip empty messages
        if not message_data:
            print("Empty message - skipping")
            return

        # ✅ Safe JSON parsing
        try:
            message_json = json.loads(message_data)
        except Exception:
            print("Invalid JSON - skipping")
            return

        # ✅ Validate keys
        if "file_name" not in message_json or "content" not in message_json:
            print("Missing required fields - skipping")
            return

        file_name = message_json["file_name"]
        file_content = base64.b64decode(message_json["content"])

        client = storage.Client()
        bucket = client.bucket("reg-reporting-490417-dev-raw")

        blob = bucket.blob(f"pub_sub_source_layer/{file_name}")
        blob.upload_from_string(file_content)

        print(f"Uploaded {file_name}")

    except Exception as e:
        print(f"Error: {str(e)}")
        raise