From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 16 May 2016 15:21:09 -0700
Subject: [Intel-wired-lan] [PATCH net-next v5 0/4] igb: enable RX
 network flow classification
In-Reply-To: <1462786062-7572-1-git-send-email-gangfeng.huang@ni.com>
References: <1462786062-7572-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <1463437269.2609.20.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-05-09 at 17:27 +0800, Gangfeng wrote:
> After apply this series of patches, igb driver will supports advanced
> RX filter that direct receive packets by flows to different hardware
> queue. Enables tight control on routing a flow in the platform.
> 
> In our product, we use the the RX traffic classification to gurantee the
> PTP(ethertype is 0x88F7) packets won't be flooded by best effort packet.
> PTP packets is always be processed by Linux network stack.
> 
> step 1.?
> ? use the ethertype filter to filter most of packet(0x0800) to HW queue;
> step 2.
> ? Add a rule to forward the PTP packets to another HW queue
> 
> The ethtool commands and options:
> 
> -n --show-nfc
> ?? Retrieves the receive network flow classification configurations
> 
> -N --config-nfc
> ?? Configures the receive network flow classification classification
> 
> Change history of this patches:
> Version 1:
> ? Split the patch to 3 patches for review;
> ? Save the filters and restore them after a reset;
> ? In ethtool command, use key word "proto" to replace "vlan-etype:
> ? Fix bugs
> Version 2:
> ? Rebase the patches on the the latest dev-queue;
> Version 3:
> ? Report a meaningful error code for misoperation;
> Version 4:
> ? Rebase the patches on latest dev-queue;
> ? Update the patch description and code comments;?
> Version 5:
> ? Rebase the patches on latest dev-queue;
> ? Update the patch description;

Based on the issues validation has found with your first patch, I am
dropping your series of patches. ?Please address the issues Aaron found
during validation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160516/6b7d9e6b/attachment-0001.asc>
