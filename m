From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 20 Aug 2015 20:37:22 +0000
Subject: [Intel-wired-lan] [PATCH 2/4] geneve: Add geneve udp port
 offload for ethernet devices
In-Reply-To: <1440096383-8915-2-git-send-email-anjali.singhai@intel.com>
References: <1440096383-8915-1-git-send-email-anjali.singhai@intel.com>
 <1440096383-8915-2-git-send-email-anjali.singhai@intel.com>
Message-ID: <1440103042.28850.5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-08-20 at 11:46 -0700, Anjali Singhai Jain wrote:
> Add ndo_ops to add/del UDP ports to a device that supports geneve
> offload.
> 
> v2:Added comments for new ndo_ops and minor format fix.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---

Am I missing something about how this would enable Tx offloads? Or is
that enabled already?

Regards,
Jake
