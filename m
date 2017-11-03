From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 3 Nov 2017 10:05:56 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 2/5] fm10k: Fix
 VLAN configuration for macvlan offload
In-Reply-To: <20171102233336.15146.31137.stgit@localhost.localdomain>
References: <20171102232857.15146.21583.stgit@localhost.localdomain>
 <20171102233336.15146.31137.stgit@localhost.localdomain>
Message-ID: <20171103100556.00001ff7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2 Nov 2017 16:33:45 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The fm10k driver didn't work correctly when macvlan offload was enabled.
> Specifically what would occur is that we would see no unicast packets being
> received. This was traced down to us not correctly configuring the default
> VLAN ID for the port and defaulting to 0.
> 
> To correct this we either use the default ID provided by the switch or
> simply use 1. With that we are able to pass and receive traffic without any
> issues.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
