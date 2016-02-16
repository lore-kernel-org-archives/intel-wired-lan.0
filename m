From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 16 Feb 2016 08:56:38 +0100
Subject: [Intel-wired-lan] [PATCH v7 4/8] time: Add driver cross
 timestamp interface for higher precision time synchronization
In-Reply-To: <1455308729-6280-5-git-send-email-christopher.s.hall@intel.com>
References: <1455308729-6280-1-git-send-email-christopher.s.hall@intel.com>
 <1455308729-6280-5-git-send-email-christopher.s.hall@intel.com>
Message-ID: <20160216075638.GB2461@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Feb 12, 2016 at 12:25:25PM -0800, Christopher S. Hall wrote:
>  /**
> + * get_device_system_crosststamp - Synchronously capture system/device timestamp
> + * @sync_devicetime:	Callback to get simultaneous device time and
> + *	system counter from the device driver
> + * @xtstamp:		Receives simultaneously captured system and device time
      @ctx:             Private context passed to the 'get_time_fn' callback.

> + *
> + * Reads a timestamp from a device and correlates it to system time
> + */

Thanks,
Richard
