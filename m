From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 14 Aug 2015 23:21:51 +0000
Subject: [Intel-wired-lan] [PATCH 1/1 net-next] e1000: remove dead
 e1000_init_eeprom_params calls.
In-Reply-To: <20150805225237.GA31471@electric-eye.fr.zoreil.com>
References: <20150805225237.GA31471@electric-eye.fr.zoreil.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81AE74DD@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Francois Romieu
> Sent: Wednesday, August 05, 2015 3:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/1 net-next] e1000: remove dead
> e1000_init_eeprom_params calls.
> 
> The device probe method e1000_probe calls e1000_init_eeprom_params
> itself so there's no reason to call it again from e1000_do_write_eeprom
> or e1000_do_read_eeprom.
> 
> The sentence above assumes that e1000_init_eeprom_params is effective.
> e1000_init_eeprom_params depends mostly on hw->mac_type and e1000_probe
> bails out early if it can't set mac_type (see e1000_init_hw_struct, then
> e1000_set_mac_type), qed.
> 
> Btw, if effective, the removed paths would had been deadlock prone when
> e1000_eeprom_spi was set:
> -> e1000_write_eeprom (takes e1000_eeprom_lock)
>    -> e1000_do_write_eeprom
>       -> e1000_init_eeprom_params
>          -> e1000_read_eeprom (takes e1000_eeprom_lock)
> 
> (same narrative with e1000_read_eeprom -> e1000_do_read_eeprom etc.)
> 
> As a final note, the candidate deadlock above can't happen in e1000_probe
> due to the way eeprom->word_size is set / tested.
> 
> Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
> ---
> 
>  Patch against davem's net-next as of
> 9dc20a649609c95ce7c5ac4282656ba627b67d49.
> 
>  I noticed these calls while looking at Joern Engel's e1000 eeprom
> read/write
>  scheduler friendly patch.
> 
>  drivers/net/ethernet/intel/e1000/e1000_hw.c | 8 --------
>  1 file changed, 8 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
