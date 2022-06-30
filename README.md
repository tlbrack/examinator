# README

Some of the things I'm assuming a couple things here given the outline:

1. Since this endpoint seems like it is supposed to create a user on the fly, I'm guessing it is meant to be fairly flexible in what it lets a client do, and is meant to both create or update.  I made it so it will alter an already set time for taking an exam rather than erroring out, etc.
2. A user is only supposed to be taking an exam once.
3. The exam window represents valid start times, so scheduling even at the end of the window is ok.
4. A first, last, phone number combination represents a unique user [exam taker].
5. Given the suggestion of an api log model, that you are looking to store logged request data in the db.
6. Security/auth etc. are out of the intended scope of the problem, as are questions like... 'Does this person even attend the college?'
7. 4XX and 2XX are acceptable for varying circumstances rather than strict 400/200 only.

I think I'd normally want to already have a user [exam taker] existing from some prior call and have this endpoint either accept a user id (if it is meant to be used by an admin/teacher) or only allow a user to sign up themselves for an exam (which means the user id couldn't be passed in).

It seems like college id might be superfluous on the request unless the same exam can be associated with multiple colleges.  If so, I'd add probably add a joining table between College and Exam and maybe reference that on ExamWindow.

UserExam represents a person signed up to start an exam at a specific datetime.  After getting started, I considered associating it to ExamWindow instead of Exam, but this should get the job done, too.

POST to user_exams is the specific endpoint for the problem.