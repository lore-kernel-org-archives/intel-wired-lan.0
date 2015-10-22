From: Michael S. Tsirkin <mst@redhat.com>
Date: Thu, 22 Oct 2015 15:51:51 +0300
Subject: [Intel-wired-lan] [Qemu-devel] [RFC Patch 05/12] IXGBE: Add new
 sysfs interface of "notify_vf"
In-Reply-To: <5627FB20.3020003@gmail.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <1445445464-5056-6-git-send-email-tianyu.lan@intel.com>
 <5627FB20.3020003@gmail.com>
Message-ID: <20151022155111-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 21, 2015 at 01:52:48PM -0700, Alexander Duyck wrote:
> Also have you even considered the MSI-X configuration on the VF?  I haven't
> seen anything anywhere that would have migrated the VF's MSI-X configuration
> from BAR 3 on one system to the new system.

Hypervisors do this for virtual devices so they can do this
for physical devices too.

-- 
MST
