Intruder Detection throught Website Tracking for Alice

The algorithm will analyze a sequence of several websites that have been visited in a row by the same person and determine whether Alice is a hacker (someone else).

Data Understanding -

-> The train set train_sessions.csv contains information on user browsing sessions where the features are:

  1) site_i - are ids of sites in this session. The mapping is given with a pickled dictionary site_dic.pkl
  2) time_j - are the timestamps of attending the corresponding site
  3) target - whether this session belongs to Alice
  
-> In the training sample train_sessions.csv :

  1) Signs of site_i are indices of visited sites (decoding is given in the pickle file with the site_dic.pkl dictionary )
  2) Signs time_j - time of site_j site visits
  
The target target attribute is the fact that the session belongs to Alice (that is, what exactly Alice went to all these sites)
The task is to make predictions for the sessions in the test sample ( test_sessions.csv ), to determine if they belong to Alice. Not necessarily limited to the proposed train_sessions.csv selection — train.zip gives basic data on the web pages visited by users, by which you can create your own training sample.
