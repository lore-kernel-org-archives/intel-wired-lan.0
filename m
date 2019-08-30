From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Fri, 30 Aug 2019 08:49:57 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v6 10/12] samples/bpf: add
 buffer recycling for unaligned chunks to xdpsock
In-Reply-To: <20190827022531.15060-11-kevin.laatz@intel.com>
References: <20190822014427.49800-1-kevin.laatz@intel.com>
 <20190827022531.15060-1-kevin.laatz@intel.com>
 <20190827022531.15060-11-kevin.laatz@intel.com>
Message-ID: <CDECD1EE-EFE2-421A-94B9-3BAF1128D5EC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 26 Aug 2019, at 19:25, Kevin Laatz wrote:

> This patch adds buffer recycling support for unaligned buffers. Since we
> don't mask the addr to 2k at umem_reg in unaligned mode, we need to make
> sure we give back the correct (original) addr to the fill queue. We achieve
> this using the new descriptor format and associated masks. The new format
> uses the upper 16-bits for the offset and the lower 48-bits for the addr.
> Since we have a field for the offset, we no longer need to modify the
> actual address. As such, all we have to do to get back the original address
> is mask for the lower 48 bits (i.e. strip the offset and we get the address
> on it's own).
>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
