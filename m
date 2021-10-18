From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 18 Oct 2021 09:27:20 -0700
Subject: [Intel-wired-lan] [PATCH linux-next] e1000e: Remove redundant
 statement
In-Reply-To: <20211018085154.853744-1-luo.penghao@zte.com.cn>
References: <20211018085154.853744-1-luo.penghao@zte.com.cn>
Message-ID: <a77dd608-1297-1522-7161-197258906ac0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/18/2021 1:51 AM, luo penghao wrote:
> This assignment statement is meaningless, because the statement
> will execute to the tag "set_itr_now".
> 
> The clang_analyzer complains as follows:
> 
> drivers/net/ethernet/intel/e1000e/netdev.c:2552:3 warning:
> 
> Value stored to 'current_itr' is never read.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
