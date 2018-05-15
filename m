From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 15 May 2018 10:23:45 -0700
Subject: [Intel-wired-lan] Does a VF know that it is "trusted"?
Message-ID: <51a0f92e-7b0e-e657-fcd8-b636ff8b7937@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If the admin has set the trusted attribute on a VF, e.g.
	ip link set dev eth4 vf 1 trust on
does the vf know it is trusted?

Is there an accepted (and simple?) way for the VF to check for its trust 
level?

sln
-- 
==================================================
Shannon Nelson           shannon.nelson at oracle.com
Parents can't afford to be squeamish
