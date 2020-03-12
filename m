From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 11 Mar 2020 18:07:36 -0700
Subject: [Intel-wired-lan] [PATCH 7/8] ice: add basic handler for
 devlink .info_get
In-Reply-To: <20200311165057.3f69e090@kicinski-fedora-PC1C0HJN>
References: <20200311213319.783841-1-jacob.e.keller@intel.com>
 <20200311213319.783841-8-jacob.e.keller@intel.com>
 <20200311165057.3f69e090@kicinski-fedora-PC1C0HJN>
Message-ID: <a4fd8740-54f0-0e83-7aba-aad715fc2af1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/11/2020 4:50 PM, Jakub Kicinski wrote:
> On Wed, 11 Mar 2020 14:33:18 -0700 Jacob Keller wrote:
>> +    * - ``fw.bundle``
>> +      - running
>> +      - 0x80002ec0
>> +      - Unique identifier of the firmware image file that was loaded onto
>> +        the device. Also referred to as the EETRACK identifier of the NVM.
> 
> Ugh, I think I mislead you in the previous discussion..
> 
> Could you s/fw.bundle/fw.bundle_id/ and make it generic? NFP has the
> "_id" at the end which I clearly forgot about..
> 

Sure thing, I hadn't noticed that either. Will do.

Thanks,
Jake
