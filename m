From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 23 Aug 2018 09:37:53 -0700
Subject: [Intel-wired-lan] [PATCH v6 03/11] igc: Add netdev
In-Reply-To: <20180823070557.12312-1-sasha.neftin@intel.com>
References: <20180823070557.12312-1-sasha.neftin@intel.com>
Message-ID: <54a5282f-df2e-378c-fdb6-124ef2bcd3b6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/23/2018 12:05 AM, Sasha Neftin wrote:

[...]

> +	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);

[...]

> +	strncpy(netdev->name, "eth%d", IFNAMSIZ);

I've mentioned this to you before: why are you setting the netdev->name 
twice, and to different values?  Besides, the OS's udev rules will 
likely change the name to something else.


> +
> +module_param(debug, int, 0);
> +MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
>   /* igc_main.c */

It would be nice to have this up above, next to the definition of int debug.

sln

