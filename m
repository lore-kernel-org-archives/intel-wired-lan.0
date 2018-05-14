From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 14 May 2018 12:54:37 -0400
Subject: [Intel-wired-lan] [PATCH v3 0/1] multi-threading device shutdown
In-Reply-To: <20180514150336.GA18769@kroah.com>
References: <20180507155402.10086-1-pasha.tatashin@oracle.com>
 <20180514150336.GA18769@kroah.com>
Message-ID: <ca8b0bf8-e848-be2a-c9f5-b01ee65551b3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/14/2018 11:03 AM, Greg KH wrote:
> On Mon, May 07, 2018 at 11:54:01AM -0400, Pavel Tatashin wrote:
>> Changelog
>> v2 - v3
>> 	- Fixed warning from kbuild test.
>> 	- Moved device_lock/device_unlock inside device_shutdown_tree().
>>
>> v1 - v2
>> 	- It turns out we cannot lock more than MAX_LOCK_DEPTH by a single
>> 	  thread. (By default this value is 48), and is used to detect
>> 	  deadlocks. So, I re-wrote the code to only lock one devices per
>> 	  thread instead of pre-locking all devices by the main thread.
>> 	- Addressed comments from Tobin C. Harding.
>> 	- As suggested by Alexander Duyck removed ixgbe changes. It can be
>> 	  done as a separate work scaling RTNL mutex.
>>
>> Do a faster shutdown by calling dev->*->shutdown(dev) in parallel.
>> device_shutdown() calls these functions for every single device but
>> only using one thread.
>>
>> Since, nothing else is running on the machine by the device_shutdown()
>> s called, there is no reason not to utilize all the available CPU
>> resources.
> 
> Ah, we can hope so.  I bet this is going to break something, so can we
> have some way of turning it on/off dynamically for when it does?

Hi Greg,

Sure, I will add a kernel parameter to optionally disable this feature in the next patch revision.

Thank you,
Pavel

> 
> thanks,
> 
> greg k-h
> 
