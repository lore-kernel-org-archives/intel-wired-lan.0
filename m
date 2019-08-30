From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Fri, 30 Aug 2019 08:39:37 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v6 02/12] ixgbe: simplify Rx
 buffer recycle
In-Reply-To: <20190827022531.15060-3-kevin.laatz@intel.com>
References: <20190822014427.49800-1-kevin.laatz@intel.com>
 <20190827022531.15060-1-kevin.laatz@intel.com>
 <20190827022531.15060-3-kevin.laatz@intel.com>
Message-ID: <C44AEBC2-7D1B-4DEE-B2A5-CFEF4A571383@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 26 Aug 2019, at 19:25, Kevin Laatz wrote:

> Currently, the dma, addr and handle are modified when we reuse Rx buffers
> in zero-copy mode. However, this is not required as the inputs to the
> function are copies, not the original values themselves. As we use the
> copies within the function, we can use the original 'obi' values
> directly without having to mask and add the headroom.
>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
