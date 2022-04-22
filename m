From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 22 Apr 2022 09:46:41 -0700
Subject: [Intel-wired-lan] [PATCH v2 intel-next 3/3] ice: add write
 functionality for GNSS TTY
In-Reply-To: <20220422114257.2238368-3-karol.kolacinski@intel.com>
References: <20220422114257.2238368-1-karol.kolacinski@intel.com>
 <20220422114257.2238368-3-karol.kolacinski@intel.com>
Message-ID: <2226bdc9-e33a-f797-1bef-3752e01d1401@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 4/22/2022 4:42 AM, Karol Kolacinski wrote:

<snip>
>   
>   /**
>    * struct gnss_serial - data used to initialize GNSS TTY port
> @@ -33,6 +50,8 @@ struct gnss_serial {
>   	struct mutex gnss_mutex; /* protects GNSS serial structure */
>   	struct kthread_worker *kworker;
>   	struct kthread_delayed_work read_work;
> +	struct kthread_work write_work;
> +	struct list_head queue;
>   };

 > drivers/net/ethernet/intel/ice/ice_gnss.h:56: warning: Function 
parameter or member 'write_work' not described in 'gnss_serial'
 > drivers/net/ethernet/intel/ice/ice_gnss.h:56: warning: Function 
parameter or member 'queue' not described in 'gnss_serial'

>   
>   #if IS_ENABLED(CONFIG_TTY)
