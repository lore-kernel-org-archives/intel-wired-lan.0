From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Fri, 30 Aug 2019 08:42:08 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v6 04/12] i40e: modify driver
 for handling offsets
In-Reply-To: <20190827022531.15060-5-kevin.laatz@intel.com>
References: <20190822014427.49800-1-kevin.laatz@intel.com>
 <20190827022531.15060-1-kevin.laatz@intel.com>
 <20190827022531.15060-5-kevin.laatz@intel.com>
Message-ID: <34527E59-0A29-4904-B794-9592C5E818C1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 26 Aug 2019, at 19:25, Kevin Laatz wrote:

> With the addition of the unaligned chunks option, we need to make sure we
> handle the offsets accordingly based on the mode we are currently running
> in. This patch modifies the driver to appropriately mask the address for
> each case.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
