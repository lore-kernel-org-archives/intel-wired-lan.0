From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 28 Feb 2018 09:16:42 -0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Fix link status in case of
 error.
In-Reply-To: <20180228052006.12074-1-bpoirier@suse.com>
References: <20180228052006.12074-1-bpoirier@suse.com>
Message-ID: <1519838202.7902.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-02-28 at 14:20 +0900, Benjamin Poirier wrote:
> Before commit 19110cfbb34d ("e1000e: Separate signaling for link
> check/link
> up"), errors which happen after "get_link_status = false" in the
> copper
> check_for_link callbacks would be ignored and the link considered up.
> After
> that commit, any error implies that the link is down. Since all
> combinations of link up/down and error/no error are possible, do the
> same
> thing as e1000e_phy_has_link_generic() and return the link status in
> a
> separate variable.
> 
> Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link
> up")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

A minor nitpick, almost every patch you send out, has your patch
title/subject ending in a period which is not needed or wanted.  Patch
titles/subjects should not be complete sentences, so they do not need
punctuation at the end.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180228/17e0bb9b/attachment.asc>
