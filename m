From: Lan Tianyu <tianyu.lan@intel.com>
Date: Thu, 29 Oct 2015 14:12:26 +0800
Subject: [Intel-wired-lan] [RFC Patch 00/12] IXGBE: Add live migration
 support for SRIOV NIC
In-Reply-To: <562E40BB.6040404@gmail.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <562A7E33.4080800@gmail.com> <562DBBC9.4000104@intel.com>
 <562E40BB.6040404@gmail.com>
Message-ID: <5631B8CA.9040805@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2015?10?26? 23:03, Alexander Duyck wrote:
> No.  I think you are missing the fact that there are 256 descriptors per
> page.  As such if you dirty just 1 you will be pulling in 255 more, of
> which you may or may not have pulled in the receive buffer for.
> 
> So for example if you have the descriptor ring size set to 256 then that
> means you are going to get whatever the descriptor ring has since you
> will be marking the entire ring dirty with every packet processed,
> however you cannot guarantee that you are going to get all of the
> receive buffers unless you go through and flush the entire ring prior to
> migrating.


Yes, that will be a problem. How about adding tag for each Rx buffer and
check the tag when deliver the Rx buffer to stack? If tag has been
overwritten, this means the packet data has been migrated.


> 
> This is why I have said you will need to do something to force the rings
> to be flushed such as initiating a PM suspend prior to migrating.  You
> need to do something to stop the DMA and flush the remaining Rx buffers
> if you want to have any hope of being able to migrate the Rx in a
> consistent state.  Beyond that the only other thing you have to worry
> about are the Rx buffers that have already been handed off to the
> stack.  However those should be handled if you do a suspend and somehow
> flag pages as dirty when they are unmapped from the DMA.
> 
> - Alex

This will be simple and maybe our first version to enable migration. But
we still hope to find a way not to disable DMA before stopping VCPU to
decrease service down time.

-- 
Best regards
Tianyu Lan
