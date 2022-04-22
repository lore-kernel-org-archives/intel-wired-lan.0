From: Kolacinski, Karol <karol.kolacinski@intel.com>
Date: Fri, 22 Apr 2022 11:46:11 +0000
Subject: [Intel-wired-lan] [PATCH intel-next 2/3] ice: add i2c write command
In-Reply-To: <76921ca9-07dc-3c26-cf48-a74274a795d0@molgen.mpg.de>
References: <20220415103139.794790-1-karol.kolacinski@intel.com>
 <20220415103139.794790-2-karol.kolacinski@intel.com>
 <76921ca9-07dc-3c26-cf48-a74274a795d0@molgen.mpg.de>
Message-ID: <MW4PR11MB58004C0C9CA45DB08BEC811286F79@MW4PR11MB5800.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Paul,

Thank you for your review.

On 4/15/22 3:55 PM, Paul Menzel wrote:
>> Add the possibility to write to connected i2c devices. FW may reject
>> the write if the device is not on allowlist.
>
>Did you use a datasheet for implementing this. If so, please mention the 
>name and revision.

Unfortunately, the original author did not leave the datasheet.

>> +/**
>> + * ice_aq_write_i2c
>> + * @hw: pointer to the hw struct
>> + * @topo_addr: topology address for a device to communicate with
>> + * @bus_addr: 7-bit I2C bus address
>> + * @addr: I2C memory address (I2C offset) with up to 16 bits
>> + * @params: I2C parameters: bit [4] - I2C address type, bits [3:0] - data size to write (0-7 bytes)
>> + * @data: pointer to data (0 to 4 bytes) to be written to the I2C device
>> + * @cd: pointer to command details structure or NULL
>
>Also document the return value?

Done.

>> + *
>> + * Write I2C (0x06E3)
>> + */
>> +int
>> +ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
>> +????????????? u16 bus_addr, __le16 addr, u8 params, u8 *data,
>> +????????????? struct ice_sq_cd *cd)
>> +{
>> +???? struct ice_aq_desc desc = { 0 };
>> +???? struct ice_aqc_i2c *cmd;
>> +???? u8 i, data_size;
>
>The loop variable should be a native type.

Done.

Kind regards,
Karol

---------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173, 80-298 Gdansk
KRS 101882
NIP 957-07-52-316
