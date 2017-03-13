From: Rouven Czerwinski <rouven@czerwinskis.de>
Date: Mon, 13 Mar 2017 07:42:30 +0100
Subject: [Intel-wired-lan] Regression: Suspend/Resume of e1000e broken on
	4.11rc1 and 4.11rc2
Message-ID: <87r3213cfd.fsf@czerwinskis.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

Commit 7e54d9d063fa239c95c21548c5267f0ef419ff56 breaks suspend/resume on
my machine and on the machine of other users, see (1,2,3) for further
information. Reverting the commit fixes the issue. Please revert the
commit until the problem is fixed.

Have a nice day,

Rouven

1: http://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20170306/008247.html
2. https://bugzilla.kernel.org/show_bug.cgi?id=194801
3. https://bugzilla.kernel.org/show_bug.cgi?id=194807
