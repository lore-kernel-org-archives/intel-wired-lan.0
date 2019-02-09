From: David Miller <davem@davemloft.net>
Date: Fri, 08 Feb 2019 22:58:50 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH net-next] fm10k: use struct_size() in
 kzalloc()
In-Reply-To: <20190208035537.GA12318@embeddedor>
References: <20190208035537.GA12318@embeddedor>
Message-ID: <20190208.225850.1465671376713835581.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 7 Feb 2019 21:55:37 -0600

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
> instance = kzalloc(size, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> Notice that, in this case, variable size is not necessary, hence
> it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
