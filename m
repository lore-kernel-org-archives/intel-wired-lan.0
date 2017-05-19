From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 19 May 2017 01:16:51 -0700
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Don't return uninitialized
	stats
In-Reply-To: <20170518.104614.1739169308591707817.davem@davemloft.net>
References: <20170425175433.ykc6ilm6uo7e6my2@f1.synalogic.ca>
 <20170517202413.18321-1-bpoirier@suse.com>
 <20170518.104614.1739169308591707817.davem@davemloft.net>
Message-ID: <1495181811.2376.0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2017-05-18 at 10:46 -0400, David Miller wrote:
> From: Benjamin Poirier <bpoirier@suse.com>
> Date: Wed, 17 May 2017 16:24:13 -0400
> 
> > Some statistics passed to ethtool are garbage because
> > e1000e_get_stats64()
> > doesn't write them, for example: tx_heartbeat_errors. This leaks kernel
> > memory to userspace and confuses users.
> > 
> > Do like ixgbe and use dev_get_stats() which first zeroes out
> > rtnl_link_stats64.
> > 
> > Fixes: 5944701df90d ("net: remove useless memset's in drivers
> > get_stats64")
> > Reported-by: Stefan Priebe <s.priebe@profihost.ag>
> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> 
> Jeff, please be sure to pick this up, thanks.

Yep, I have it in my tree, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170519/af01001c/attachment.asc>
