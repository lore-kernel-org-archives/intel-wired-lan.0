From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 24 Jun 2021 16:15:01 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix ping is lost after
 untrusted VF had tried to change MAC
In-Reply-To: <20210623130842.9956-1-mateusz.palczewski@intel.com>
References: <20210623130842.9956-1-mateusz.palczewski@intel.com>
Message-ID: <7e07a24f8f62dc8edc618a7944c8481278b20b55.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-06-23 at 13:08 +0000, Mateusz Palczewski wrote:
> From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> 
> Make changes to MAC address dependent on the response of PF.
> Disallow changes to hw mac address and mac filter from untrusted
> VF, thanks to that ping is not lost if VF tries to change MAC.
> Add a new field in iavf_mac_filter, to indicate whether there
> was response from PF for given filter. Based on this field pass
> or discard the filter.
> If untrusted VF tried to change it's address, it's not changed.
> Still filter was changed, because of that ping couldn't go through.
> 
> Fixes: c5c922b3e09b ("iavf: fix MAC address setting for VFs when
> filter is rejected")
> Signed-off-by: Przemyslaw Patynowski <
> przemyslawx.patynowski at intel.com>
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---

<snip>

> +/**
> + * iavf_is_mac_add_ok

Please fix this to match the function name.

warning: expecting prototype for iavf_is_mac_add_ok(). Prototype was
for iavf_mac_add_ok() instead

> + * @adapter: adapter structure
> + *
> + * Submit list of filters based on PF response.
> + **/
> +static void iavf_mac_add_ok(struct iavf_adapter *adapter)
> +{
> +	struct iavf_mac_filter *f, *ftmp;
> +
> +	spin_lock_bh(&adapter->mac_vlan_list_lock);
> +	list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list,
> list) {
> +		f->is_new_mac = false;
> +	}
> +	spin_unlock_bh(&adapter->mac_vlan_list_lock);
> +}
> +
> +/**
> + * iavf_is_mac_add_reject

Same here.

warning: expecting prototype for iavf_is_mac_add_reject(). Prototype
was for iavf_mac_add_reject() instead

> + * @adapter: adapter structure
> + *
> + * Remove filters from list based on PF response.
> + **/
> +static void iavf_mac_add_reject(struct iavf_adapter *adapter)

