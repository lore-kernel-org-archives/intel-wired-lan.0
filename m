From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Fri, 30 Aug 2019 08:51:38 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v6 12/12] doc/af_xdp: include
 unaligned chunk case
In-Reply-To: <20190827022531.15060-13-kevin.laatz@intel.com>
References: <20190822014427.49800-1-kevin.laatz@intel.com>
 <20190827022531.15060-1-kevin.laatz@intel.com>
 <20190827022531.15060-13-kevin.laatz@intel.com>
Message-ID: <320E20FD-E042-48AC-B52C-2E34FEA6A68E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 26 Aug 2019, at 19:25, Kevin Laatz wrote:

> The addition of unaligned chunks mode, the documentation needs to be
> updated to indicate that the incoming addr to the fill ring will only be
> masked if the user application is run in the aligned chunk mode. This patch
> also adds a line to explicitly indicate that the incoming addr will not be
> masked if running the user application in the unaligned chunk mode.
>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
