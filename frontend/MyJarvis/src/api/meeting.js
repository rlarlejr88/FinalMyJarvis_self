import axios from 'axios';

export const fetchMeetings = async () => {
  const response = await axios.get('/api/meetings');
  return response.data;
};

export const summarizeMeeting = async (meetingId) => {
  const response = await axios.post(`/api/meetings/${meetingId}/summary`);
  return response.data;
};

export const extractTags = async (meetingId) => {
  const response = await axios.post(`/api/meetings/${meetingId}/tags`);
  return response.data;
};

export const updateMeeting = async (meetingId, data) => {
  const response = await axios.put(`/api/meetings/${meetingId}`, data);
  return response.data;
};

export const deleteMeeting = async (meetingId) => {
  const response = await axios.delete(`/api/meetings/${meetingId}`);
  return response.data;
};
