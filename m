From: David Miller <davem@davemloft.net>
Date: Thu, 03 Jan 2019 16:37:16 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH 3/8] i40e: increase indentation
In-Reply-To: <2320c3ac2267d17ee9fc9ff3e3df60b7ca405590.camel@intel.com>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
 <1546185195-25676-4-git-send-email-Julia.Lawall@lip6.fr>
 <2320c3ac2267d17ee9fc9ff3e3df60b7ca405590.camel@intel.com>
Message-ID: <20190103.163716.1927360927242144906.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 03 Jan 2019 15:58:10 -0800

> On Sun, 2018-12-30 at 16:53 +0100, Julia Lawall wrote:
>> Convert spaces to tabs to get correct alignment.
>> 
>> Found with the help of Coccinelle.
>> 
>> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>> 
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e_main.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> 
> Dave, since this is apart of a series, please feel free to commit this
> patch with the series.

It's kind of net-next material and therefore would need to be re-submitted
anyways when net-next opens up.

Alternatively, Jeff, you can toss it into your -next tree.
