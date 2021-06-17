#!/bin/sh
cd /dist
tar c --numeric-owner * 2>/dev/null |base64
