From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Fri, 30 Aug 2019 08:41:21 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v6 03/12] xsk: add support to
 allow unaligned chunk placement
In-Reply-To: <20190827022531.15060-4-kevin.laatz@intel.com>
References: <20190822014427.49800-1-kevin.laatz@intel.com>
 <20190827022531.15060-1-kevin.laatz@intel.com>
 <20190827022531.15060-4-kevin.laatz@intel.com>
Message-ID: <071FC949-1F73-40EB-AE2E-FBFEE4F956B3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 26 Aug 2019, at 19:25, Kevin Laatz wrote:

> Currently, addresses are chunk size aligned. This means, we are very
> restricted in terms of where we can place chunk within the umem. For
> example, if we have a chunk size of 2k, then our chunks can only be placed
> at 0,2k,4k,6k,8k... and so on (ie. every 2k starting from 0).
>
> This patch introduces the ability to use unaligned chunks. With these
> changes, we are no longer bound to having to place chunks at a 2k (or
> whatever your chunk size is) interval. Since we are no longer dealing with
> aligned chunks, they can now cross page boundaries. Checks for page
> contiguity have been added in order to keep track of which pages are
> followed by a physically contiguous page.
>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
