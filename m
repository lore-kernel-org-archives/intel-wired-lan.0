From: Aaron Sierra <asierra@xes-inc.com>
Date: Wed, 12 Oct 2016 15:46:33 -0500 (CDT)
Subject: [Intel-wired-lan] Bug with 'igb: Remove GS40G specific
	defines/functions'
In-Reply-To: <20F028E5-EC20-4F65-8889-3F254196ABF8@vectranetworks.com>
References: <77C85CBC-39FD-40B4-9456-56A3FEE3544A@vectranetworks.com>
 <1570773976.567827.1476303559656.JavaMail.zimbra@xes-inc.com>
 <20F028E5-EC20-4F65-8889-3F254196ABF8@vectranetworks.com>
Message-ID: <133564642.602581.1476305193640.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Chris,

> I?m not sure exactly which part I need to comment out to verify in
> ?igb_init_phy_params_82575()?.
> Is there a fix already planned for this? Any additional information I can
> provide?

Did you follow any of the "Next message" links? There is more to the
discussion than that first page that I linked to.

In that discussion we determined that the PHY was somehow setup with a
non-zero register page setting. That was treated as a BIOS bug rather
than a driver bug.

If you're having the same problem, then it could be possible to explicitly
set the default page to zero, but I'm not sure where that _should_ be done
or if that is generally the correct/safe thing to do.

-Aaron
