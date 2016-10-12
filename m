From: Chris Arges <carges@vectranetworks.com>
Date: Wed, 12 Oct 2016 19:51:41 +0000
Subject: [Intel-wired-lan] Bug with 'igb: Remove GS40G specific
	defines/functions'
Message-ID: <77C85CBC-39FD-40B4-9456-56A3FEE3544A@vectranetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I have an Intel I210 NIC which shows:
'igb: probe of 0000:07:00.0 failed wtih error -2'
Upon boot after power has been completely disconnected.

v4.4 works, while v4.5 fails and I was able to bisect it down to:
commit 2a3cdead8b408351fa1e3079b220fa331480ffbc

Any ideas for a fix? I'm happy to test any patches.

(apologies for the resend, typed the wrong address.)

--chris


