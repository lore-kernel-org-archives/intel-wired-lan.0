From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Fri, 30 Aug 2019 08:51:12 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v6 11/12] samples/bpf: use
 hugepages in xdpsock app
In-Reply-To: <20190827022531.15060-12-kevin.laatz@intel.com>
References: <20190822014427.49800-1-kevin.laatz@intel.com>
 <20190827022531.15060-1-kevin.laatz@intel.com>
 <20190827022531.15060-12-kevin.laatz@intel.com>
Message-ID: <359B63E6-49B0-4AA2-96F3-D139AF0AEA33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 26 Aug 2019, at 19:25, Kevin Laatz wrote:

> This patch modifies xdpsock to use mmap instead of posix_memalign. With
> this change, we can use hugepages when running the application in unaligned
> chunks mode. Using hugepages makes it more likely that we have physically
> contiguous memory, which supports the unaligned chunk mode better.
>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
