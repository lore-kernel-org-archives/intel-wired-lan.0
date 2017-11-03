From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 3 Nov 2017 10:07:33 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 5/5] dev: Cap
 number of queues even with accel_priv
In-Reply-To: <20171102233447.15146.63844.stgit@localhost.localdomain>
References: <20171102232857.15146.21583.stgit@localhost.localdomain>
 <20171102233447.15146.63844.stgit@localhost.localdomain>
Message-ID: <20171103100733.000026fc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2 Nov 2017 16:34:58 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> With the recent fix to ixgbe we can cap the number of queues always
> regardless of if accel_priv is being used or not since the actual number of
> queues are being reported via real_num_tx_queues.

Makes sense.
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
