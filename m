From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Fri, 30 Aug 2019 08:47:26 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v6 09/12] samples/bpf: add
 unaligned chunks mode support to xdpsock
In-Reply-To: <20190827022531.15060-10-kevin.laatz@intel.com>
References: <20190822014427.49800-1-kevin.laatz@intel.com>
 <20190827022531.15060-1-kevin.laatz@intel.com>
 <20190827022531.15060-10-kevin.laatz@intel.com>
Message-ID: <33E70F88-0C7B-48EF-9591-DBC17D2A09B6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 26 Aug 2019, at 19:25, Kevin Laatz wrote:

> This patch adds support for the unaligned chunks mode. The addition of the
> unaligned chunks option will allow users to run the application with more
> relaxed chunk placement in the XDP umem.
>
> Unaligned chunks mode can be used with the '-u' or '--unaligned' command
> line options.
>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
