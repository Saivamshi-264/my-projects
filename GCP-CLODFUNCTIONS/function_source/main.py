import logging

def file_upload_trigger(event, context):
    """Triggered by Cloud Storage uploads."""
    file_name = event['name']
    bucket_name = event['bucket']
    logging.info(f"New file uploaded: {file_name} in bucket: {bucket_name}")
