From: Lan, Tianyu <tianyu.lan@intel.com>
Date: Sat, 24 Oct 2015 23:43:37 +0800
Subject: [Intel-wired-lan] [RFC Patch 05/12] IXGBE: Add new sysfs
	interface of "notify_vf"
In-Reply-To: <5627FB20.3020003@gmail.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <1445445464-5056-6-git-send-email-tianyu.lan@intel.com>
 <5627FB20.3020003@gmail.com>
Message-ID: <562BA729.10903@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/22/2015 4:52 AM, Alexander Duyck wrote:
> Also have you even considered the MSI-X configuration on the VF?  I
> haven't seen anything anywhere that would have migrated the VF's MSI-X
> configuration from BAR 3 on one system to the new system.

MSI-X migration is done by Hypervisor(Qemu).
Following link is my Qemu patch to do that.
http://marc.info/?l=kvm&m=144544706530484&w=2
