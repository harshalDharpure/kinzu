# KizunaBot Deployment Guide

## Overview
- **Frontend (Japanese):** Deploy to Vercel (`kizunafront-jp`)
- **Backend:** Deploy to Render
- **Database:** AWS DynamoDB
- **File Storage:** AWS S3
- **AI Analysis:** Google Gemini API

## Backend Deployment (Render)

### 1. Render Configuration
- **Service Type:** Web Service
- **Name:** `kinzubackend-1`
- **Language:** Node
- **Branch:** `main`
- **Root Directory:** `kizunaback`
- **Build Command:** `npm run build`
- **Start Command:** `npm start`
- **Instance Type:** Starter ($7/month) - Recommended

### 2. Environment Variables (Required)
```
JWT_SECRET=your_secure_jwt_secret_here
AWS_ACCESS_KEY_ID=your_aws_access_key
AWS_SECRET_ACCESS_KEY=your_aws_secret_key
AWS_REGION=us-east-1
GEMINI_API_KEY=your_gemini_api_key
NODE_ENV=production
PORT=5000
```

### 3. AWS Setup Required
- **DynamoDB Table:** For user data and recordings
- **S3 Bucket:** For audio file storage
- **IAM User:** With DynamoDB and S3 permissions

### 4. Google Gemini API
- Get API key from: https://makersuite.google.com/app/apikey

## Frontend Deployment (Vercel) - Japanese Version

### 1. Vercel Configuration
- **Framework Preset:** Vite
- **Build Command:** `npm run build`
- **Output Directory:** `dist`
- **Root Directory:** `kizunafront-jp`

### 2. Environment Variables
```
VITE_BACKEND_URL=https://kinzubackend-1.onrender.com
VITE_API_URL=https://kinzubackend-1.onrender.com
```

### 3. Deployment Steps
1. Connect GitHub repository to Vercel
2. **Important:** Select `kizunafront-jp` as the root directory
3. Set environment variables in Vercel dashboard
4. Deploy automatically on push to main

## Deployment Order

### Step 1: Deploy Backend First
1. Push your code to GitHub
2. Create Render web service
3. Configure environment variables
4. Deploy and test backend endpoints

### Step 2: Deploy Frontend
1. Update frontend environment variables with backend URL
2. Deploy to Vercel (selecting `kizunafront-jp` directory)
3. Test full application

## Testing Checklist

### Backend Tests
- [ ] Health check: `GET /`
- [ ] Authentication: `POST /api/auth/login`
- [ ] Audio analysis: `POST /api/analyze/audio`
- [ ] Gemini insights: `POST /api/gemini/analyze`

### Frontend Tests
- [ ] Login/Signup functionality
- [ ] Audio file upload
- [ ] Analysis results display
- [ ] Recording history
- [ ] Japanese language support

## Troubleshooting

### Common Issues:
1. **Python Dependencies:** Ensure build.sh runs successfully
2. **CORS Errors:** Backend CORS is configured for frontend domain
3. **Environment Variables:** Check all required variables are set
4. **AWS Permissions:** Verify IAM user has correct permissions
5. **Wrong Directory:** Make sure Vercel is using `kizunafront-jp` directory

### Debug Commands:
```bash
# Check backend logs
render logs --service kinzubackend-1

# Check frontend build
vercel logs --follow
```

## Security Notes
- Keep JWT_SECRET secure and unique
- Use environment variables for all secrets
- Enable HTTPS for production
- Set up proper CORS origins 