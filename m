From: Michael S. Tsirkin <mst@redhat.com>
Date: Thu, 22 Oct 2015 15:55:34 +0300
Subject: [Intel-wired-lan] [Qemu-devel] [RFC Patch 00/12] IXGBE: Add
 live migration support for SRIOV NIC
In-Reply-To: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
Message-ID: <20151022155234-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Oct 22, 2015 at 12:37:32AM +0800, Lan Tianyu wrote:
> This patchset is to propose a new solution to add live migration support for 82599
> SRIOV network card.
> 
> Im our solution, we prefer to put all device specific operation into VF and
> PF driver and make code in the Qemu more general.

Adding code to VF driver makes sense.  However, adding code to PF driver
is problematic: PF and VF run within different environments, you can't
assume PF and VF drivers are the same version.

I guess that would be acceptable if these messages make
it into the official intel spec, along with
hardware registers.

-- 
MST
