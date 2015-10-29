From: Lan Tianyu <tianyu.lan@intel.com>
Date: Thu, 29 Oct 2015 16:33:06 +0800
Subject: [Intel-wired-lan] [RFC Patch 00/12] IXGBE: Add live migration
 support for SRIOV NIC
In-Reply-To: <5631C3A7.2070900@gmail.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <562A7E33.4080800@gmail.com> <562DBBC9.4000104@intel.com>
 <562E40BB.6040404@gmail.com> <5631B8CA.9040805@intel.com>
 <5631C3A7.2070900@gmail.com>
Message-ID: <5631D9C2.2040206@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2015?10?29? 14:58, Alexander Duyck wrote:
> 
> Your code was having to do a bunch of shuffling in order to get things
> set up so that you could bring the interface back up.  I would argue
> that it may actually be faster at least on the bring-up to just drop the
> old rings and start over since it greatly reduced the complexity and the
> amount of device related data that has to be moved.

If give up the old ring after migration and keep DMA running before
stopping VCPU, it seems we don't need to track Tx/Rx descriptor ring and
just make sure that all Rx buffers delivered to stack has been migrated.

1) Dummy write Rx buffer before checking Rx descriptor to ensure packet
migrated first.

2) Make a copy of Rx descriptor and then use the copied data to check
buffer status. Not use the original descriptor because it won't be
migrated and migration may happen between two access of the Rx descriptor.

-- 
Best regards
Tianyu Lan
