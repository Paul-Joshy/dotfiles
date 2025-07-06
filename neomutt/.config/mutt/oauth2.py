#!/usr/bin/env python3
"""
OAuth2 script for Gmail authentication with Neomutt and mbsync
"""

import json
import os
import sys
from pathlib import Path
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials

# OAuth2 scopes for Gmail
SCOPES = [
    'https://www.googleapis.com/auth/gmail.readonly',
    'https://www.googleapis.com/auth/gmail.send',
    'https://www.googleapis.com/auth/gmail.modify',
    'https://www.googleapis.com/auth/gmail.compose'
]

def get_oauth_token():
    """Get OAuth2 token for Gmail access"""
    
    # Paths
    config_dir = Path.home() / ".config" / "mutt"
    credentials_file = config_dir / "gmail-oauth2.json"
    token_file = config_dir / "token.json"
    
    # Check if credentials file exists
    if not credentials_file.exists():
        print("Error: gmail-oauth2.json not found", file=sys.stderr)
        sys.exit(1)
    
    creds = None
    
    # Load existing token if available
    if token_file.exists():
        try:
            creds = Credentials.from_authorized_user_file(str(token_file), SCOPES)
        except Exception as e:
            print(f"Error loading token: {e}", file=sys.stderr)
    
    # If no valid credentials available, let the user log in
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            try:
                creds.refresh(Request())
            except Exception as e:
                print(f"Error refreshing token: {e}", file=sys.stderr)
                creds = None
        
        if not creds:
            try:
                # Load client configuration
                with open(credentials_file, 'r') as f:
                    client_config = json.load(f)
                
                # Create flow - use the 'installed' key from the downloaded credentials
                flow = InstalledAppFlow.from_client_config(
                    client_config, SCOPES)
                
                # Run the OAuth flow
                creds = flow.run_local_server(port=8080)
                
                # Save the credentials for the next run
                with open(token_file, 'w') as f:
                    f.write(creds.to_json())
                    
            except Exception as e:
                print(f"Error during OAuth flow: {e}", file=sys.stderr)
                sys.exit(1)
    
    # Return the access token
    if creds and creds.token:
        return creds.token
    else:
        print("Error: No valid token available", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    try:
        token = get_oauth_token()
        print(token)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1) 