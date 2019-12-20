From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 20 Dec 2019 20:21:27 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] drivers: net: i40e:
 Removing hung_queue variable to use txqueue function parameter
In-Reply-To: <20191218183845.20038-2-jcfaracco@gmail.com>
References: <20191218183845.20038-1-jcfaracco@gmail.com>
 <20191218183845.20038-2-jcfaracco@gmail.com>
Message-ID: <18fd3069be264c82865760ce61f588b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Julio Faracco
> Sent: Wednesday, December 18, 2019 10:39 AM
> To: netdev at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH net-next 1/2] drivers: net: i40e: Removing
> hung_queue variable to use txqueue function parameter
> 
> The scope of function .ndo_tx_timeout was changed to include the hang
> queue when a TX timeout event occurs. See commit 0290bd291cc0
> ("netdev: pass the stuck queue to the timeout handler") for more details.
> Now, drivers don't need to identify which queue is stopped.
> Drivers can simply use the queue index provided bt dev_watchdog and
> execute all actions needed to restore network traffic. This commit do some
> cleanups into Intel i40e driver to remove a redundant loop to find stopped
> queue.
> 
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 41 ++++++---------------
>  1 file changed, 11 insertions(+), 30 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


