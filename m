From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 29 Mar 2019 15:37:33 -0700
Subject: [Intel-wired-lan] [PATCH][next] iavf: iavf_client: use
 struct_size() helper
In-Reply-To: <20190328203613.GA23692@embeddedor>
References: <20190328203613.GA23692@embeddedor>
Message-ID: <59cd9dd2381c029fe0ca81510f016e28ff906f18.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-03-28 at 15:36 -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(struct boo);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> size = struct_size(instance, entry, count);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_client.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Thanks Gustavo, I will queue this up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190329/4f2ac4b2/attachment.asc>
