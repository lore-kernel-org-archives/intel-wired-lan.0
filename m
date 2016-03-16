From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 16 Mar 2016 19:01:57 -0400
Subject: [Intel-wired-lan] [PATCH V3 net-next] ixgbe: Avoid unaligned
 access in ixgbe_atr() for LLC packets
In-Reply-To: <1458169132.2878.25.camel@intel.com>
References: <20160314194716.GM5084@oracle.com>
 <1458169132.2878.25.camel@intel.com>
Message-ID: <20160316230157.GK21307@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On (03/16/16 15:58), Jeff Kirsher wrote:
> 
> This does not apply since Alex Duyck beat you to the fix. ?Here is the
> patch he submitted on 3/15 which corrects the issue. ?So I am dropping
> your patch from the queue.
> 

That's weird because Alexander was reviewing my fix on the various
lists yesterday, so he could have just told me about this.

But, whatever.

--sowmini


