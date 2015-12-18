From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Fri, 18 Dec 2015 01:56:38 +0000
Subject: [Intel-wired-lan] [next PATCH] igb/igbvf: don't give up
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E30D1D@ORSMSX101.amr.corp.intel.com>
References: <1449881138-19985-1-git-send-email-mitch.a.williams@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81E30D1D@ORSMSX101.amr.corp.intel.com>
Message-ID: <8FF04C88-EEDB-4234-A368-CED5C387348B@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Aaron F <aaron.f.brown@intel.com> wrote:

> Is there any reason not to use usleep_range here?

Can the routines ever be called from any atomic context, such as an interrupt or while a lock is held? If so, you can't use any form of sleep.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151218/22af9160/attachment.asc>
