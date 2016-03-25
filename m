From: William Dauchy <william@gandi.net>
Date: Fri, 25 Mar 2016 16:22:56 +0100
Subject: [Intel-wired-lan] dynamically set number of queues for 82598
	devices in -stable
In-Reply-To: <20151127100557.GB21147@gandi.net>
References: <20151127100557.GB21147@gandi.net>
Message-ID: <20160325152256.GA20821@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff,

Any chance to get an opinion on that?

Thanks,

On Nov27 11:05, William Dauchy wrote:
> Hello Jeff,
> 
> I faced the problem described in commit 7e3f5c8:
> ixgbe: fix bounds checking in ixgbe_setup_tc for 82598
> 
> This patch resolves an issue where users were not able to dynamically
> set number of queues for 82598 via ethtool -L
> 
> 
> I backported it for my v4.1.x build but I was wondering if this could be
> a candidate for a backport in stable tree at least for v4.1.x.

-- 
William
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160325/0a8356b9/attachment.asc>
