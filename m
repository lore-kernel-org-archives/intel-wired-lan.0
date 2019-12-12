From: David Miller <davem@davemloft.net>
Date: Thu, 12 Dec 2019 10:49:56 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH] igb: index regs_buff array via index
 variable
In-Reply-To: <20191212105847.16488-1-gomonovych@gmail.com>
References: <20191212105847.16488-1-gomonovych@gmail.com>
Message-ID: <20191212.104956.2134616389786003650.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vasyl Gomonovych <gomonovych@gmail.com>
Date: Thu, 12 Dec 2019 11:58:47 +0100

> This patch is just a preparation for additional register dump in regs_buff.
> To make new register insertion in the middle of regs_buff array easier
> change array indexing to use local counter reg_ix.
> 
> ---
> 
> Basically this path is just a subject to ask
> How to add a new register to dump from dataseet
> Because it is logically better to add an additional register
> in the middle of an array but that will break ABI.
> To not have the ABI problem we should just add it at the
> end of the array and increase the array size.
> 
> ---
> 
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>

Anything you put after "---" will be removed by git if someone actually
applies this patch, which means your signoff will disappear.
