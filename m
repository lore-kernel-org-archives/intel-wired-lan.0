From: kernel test robot <lkp@intel.com>
Date: Tue, 11 Aug 2020 01:39:57 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 32/33]
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4117:50: sparse: sparse:
 incorrect type in initializer (different base types)
Message-ID: <202008110155.7a7PDhNn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5cf0cbb14925b7131baa959b35a2267d6bbb6651
commit: f9f6d7ca51320f99e7d1c1b8facc5c129e9c413f [32/33] i40e: Add flow director support for IPv6
config: x86_64-randconfig-s022-20200810 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-141-g19506bc2-dirty
        git checkout f9f6d7ca51320f99e7d1c1b8facc5c129e9c413f
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4117:50: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be32 @@     got unsigned int @@
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4117:50: sparse:     expected restricted __be32
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4117:50: sparse:     got unsigned int
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4117:62: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be32 @@     got unsigned int @@
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4117:62: sparse:     expected restricted __be32
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4117:62: sparse:     got unsigned int
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4118:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be32 @@     got unsigned int @@
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4118:17: sparse:     expected restricted __be32
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4118:17: sparse:     got unsigned int
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4118:29: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be32 @@     got unsigned int @@
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4118:29: sparse:     expected restricted __be32
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4118:29: sparse:     got unsigned int

vim +4117 drivers/net/ethernet/intel/i40e/i40e_ethtool.c

  4087	
  4088	/**
  4089	 * i40e_check_fdir_input_set - Check that a given rx_flow_spec mask is valid
  4090	 * @vsi: pointer to the targeted VSI
  4091	 * @fsp: pointer to Rx flow specification
  4092	 * @userdef: userdefined data from flow specification
  4093	 *
  4094	 * Ensures that a given ethtool_rx_flow_spec has a valid mask. Some support
  4095	 * for partial matches exists with a few limitations. First, hardware only
  4096	 * supports masking by word boundary (2 bytes) and not per individual bit.
  4097	 * Second, hardware is limited to using one mask for a flow type and cannot
  4098	 * use a separate mask for each filter.
  4099	 *
  4100	 * To support these limitations, if we already have a configured filter for
  4101	 * the specified type, this function enforces that new filters of the type
  4102	 * match the configured input set. Otherwise, if we do not have a filter of
  4103	 * the specified type, we allow the input set to be updated to match the
  4104	 * desired filter.
  4105	 *
  4106	 * To help ensure that administrators understand why filters weren't displayed
  4107	 * as supported, we print a diagnostic message displaying how the input set
  4108	 * would change and warning to delete the preexisting filters if required.
  4109	 *
  4110	 * Returns 0 on successful input set match, and a negative return code on
  4111	 * failure.
  4112	 **/
  4113	static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
  4114					     struct ethtool_rx_flow_spec *fsp,
  4115					     struct i40e_rx_flow_userdef *userdef)
  4116	{
> 4117		static const __be32 ipv6_full_mask[4] = {0xffffffff, 0xffffffff,
  4118			0xffffffff, 0xffffffff};
  4119		struct ethtool_tcpip6_spec *tcp_ip6_spec;
  4120		struct ethtool_usrip6_spec *usr_ip6_spec;
  4121		struct ethtool_tcpip4_spec *tcp_ip4_spec;
  4122		struct ethtool_usrip4_spec *usr_ip4_spec;
  4123		struct i40e_pf *pf = vsi->back;
  4124		u64 current_mask, new_mask;
  4125		bool new_flex_offset = false;
  4126		bool flex_l3 = false;
  4127		u16 *fdir_filter_count;
  4128		u16 index, src_offset = 0;
  4129		u8 pit_index = 0;
  4130		int err;
  4131	
  4132		switch (fsp->flow_type & ~FLOW_EXT) {
  4133		case SCTP_V4_FLOW:
  4134			index = I40E_FILTER_PCTYPE_NONF_IPV4_SCTP;
  4135			fdir_filter_count = &pf->fd_sctp4_filter_cnt;
  4136			break;
  4137		case TCP_V4_FLOW:
  4138			index = I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
  4139			fdir_filter_count = &pf->fd_tcp4_filter_cnt;
  4140			break;
  4141		case UDP_V4_FLOW:
  4142			index = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
  4143			fdir_filter_count = &pf->fd_udp4_filter_cnt;
  4144			break;
  4145		case SCTP_V6_FLOW:
  4146			index = I40E_FILTER_PCTYPE_NONF_IPV6_SCTP;
  4147			fdir_filter_count = &pf->fd_sctp6_filter_cnt;
  4148			break;
  4149		case TCP_V6_FLOW:
  4150			index = I40E_FILTER_PCTYPE_NONF_IPV6_TCP;
  4151			fdir_filter_count = &pf->fd_tcp6_filter_cnt;
  4152			break;
  4153		case UDP_V6_FLOW:
  4154			index = I40E_FILTER_PCTYPE_NONF_IPV6_UDP;
  4155			fdir_filter_count = &pf->fd_udp6_filter_cnt;
  4156			break;
  4157		case IP_USER_FLOW:
  4158			index = I40E_FILTER_PCTYPE_NONF_IPV4_OTHER;
  4159			fdir_filter_count = &pf->fd_ip4_filter_cnt;
  4160			flex_l3 = true;
  4161			break;
  4162		case IPV6_USER_FLOW:
  4163			index = I40E_FILTER_PCTYPE_NONF_IPV6_OTHER;
  4164			fdir_filter_count = &pf->fd_ip6_filter_cnt;
  4165			flex_l3 = true;
  4166			break;
  4167		default:
  4168			return -EOPNOTSUPP;
  4169		}
  4170	
  4171		/* Read the current input set from register memory. */
  4172		current_mask = i40e_read_fd_input_set(pf, index);
  4173		new_mask = current_mask;
  4174	
  4175		/* Determine, if any, the required changes to the input set in order
  4176		 * to support the provided mask.
  4177		 *
  4178		 * Hardware only supports masking at word (2 byte) granularity and does
  4179		 * not support full bitwise masking. This implementation simplifies
  4180		 * even further and only supports fully enabled or fully disabled
  4181		 * masks for each field, even though we could split the ip4src and
  4182		 * ip4dst fields.
  4183		 */
  4184		switch (fsp->flow_type & ~FLOW_EXT) {
  4185		case SCTP_V4_FLOW:
  4186			new_mask &= ~I40E_VERIFY_TAG_MASK;
  4187			fallthrough;
  4188		case TCP_V4_FLOW:
  4189		case UDP_V4_FLOW:
  4190			tcp_ip4_spec = &fsp->m_u.tcp_ip4_spec;
  4191	
  4192			/* IPv4 source address */
  4193			if (tcp_ip4_spec->ip4src == htonl(0xFFFFFFFF))
  4194				new_mask |= I40E_L3_SRC_MASK;
  4195			else if (!tcp_ip4_spec->ip4src)
  4196				new_mask &= ~I40E_L3_SRC_MASK;
  4197			else
  4198				return -EOPNOTSUPP;
  4199	
  4200			/* IPv4 destination address */
  4201			if (tcp_ip4_spec->ip4dst == htonl(0xFFFFFFFF))
  4202				new_mask |= I40E_L3_DST_MASK;
  4203			else if (!tcp_ip4_spec->ip4dst)
  4204				new_mask &= ~I40E_L3_DST_MASK;
  4205			else
  4206				return -EOPNOTSUPP;
  4207	
  4208			/* L4 source port */
  4209			if (tcp_ip4_spec->psrc == htons(0xFFFF))
  4210				new_mask |= I40E_L4_SRC_MASK;
  4211			else if (!tcp_ip4_spec->psrc)
  4212				new_mask &= ~I40E_L4_SRC_MASK;
  4213			else
  4214				return -EOPNOTSUPP;
  4215	
  4216			/* L4 destination port */
  4217			if (tcp_ip4_spec->pdst == htons(0xFFFF))
  4218				new_mask |= I40E_L4_DST_MASK;
  4219			else if (!tcp_ip4_spec->pdst)
  4220				new_mask &= ~I40E_L4_DST_MASK;
  4221			else
  4222				return -EOPNOTSUPP;
  4223	
  4224			/* Filtering on Type of Service is not supported. */
  4225			if (tcp_ip4_spec->tos)
  4226				return -EOPNOTSUPP;
  4227	
  4228			break;
  4229		case SCTP_V6_FLOW:
  4230			new_mask &= ~I40E_VERIFY_TAG_MASK;
  4231			fallthrough;
  4232		case TCP_V6_FLOW:
  4233		case UDP_V6_FLOW:
  4234			tcp_ip6_spec = &fsp->m_u.tcp_ip6_spec;
  4235	
  4236			/* Check if user provided IPv6 source address. */
  4237			if (ipv6_addr_equal((struct in6_addr *)&tcp_ip6_spec->ip6src,
  4238					    (struct in6_addr *)&ipv6_full_mask))
  4239				new_mask |= I40E_L3_V6_SRC_MASK;
  4240			else if (ipv6_addr_any((struct in6_addr *)
  4241					       &tcp_ip6_spec->ip6src))
  4242				new_mask &= ~I40E_L3_V6_SRC_MASK;
  4243			else
  4244				return -EOPNOTSUPP;
  4245	
  4246			/* Check if user provided destination address. */
  4247			if (ipv6_addr_equal((struct in6_addr *)&tcp_ip6_spec->ip6dst,
  4248					    (struct in6_addr *)&ipv6_full_mask))
  4249				new_mask |= I40E_L3_V6_DST_MASK;
  4250			else if (ipv6_addr_any((struct in6_addr *)
  4251					       &tcp_ip6_spec->ip6src))
  4252				new_mask &= ~I40E_L3_V6_DST_MASK;
  4253			else
  4254				return -EOPNOTSUPP;
  4255	
  4256			/* L4 source port */
  4257			if (tcp_ip6_spec->psrc == htons(0xFFFF))
  4258				new_mask |= I40E_L4_SRC_MASK;
  4259			else if (!tcp_ip6_spec->psrc)
  4260				new_mask &= ~I40E_L4_SRC_MASK;
  4261			else
  4262				return -EOPNOTSUPP;
  4263	
  4264			/* L4 destination port */
  4265			if (tcp_ip6_spec->pdst == htons(0xFFFF))
  4266				new_mask |= I40E_L4_DST_MASK;
  4267			else if (!tcp_ip6_spec->pdst)
  4268				new_mask &= ~I40E_L4_DST_MASK;
  4269			else
  4270				return -EOPNOTSUPP;
  4271	
  4272			/* Filtering on Traffic Classes is not supported. */
  4273			if (tcp_ip6_spec->tclass)
  4274				return -EOPNOTSUPP;
  4275			break;
  4276		case IP_USER_FLOW:
  4277			usr_ip4_spec = &fsp->m_u.usr_ip4_spec;
  4278	
  4279			/* IPv4 source address */
  4280			if (usr_ip4_spec->ip4src == htonl(0xFFFFFFFF))
  4281				new_mask |= I40E_L3_SRC_MASK;
  4282			else if (!usr_ip4_spec->ip4src)
  4283				new_mask &= ~I40E_L3_SRC_MASK;
  4284			else
  4285				return -EOPNOTSUPP;
  4286	
  4287			/* IPv4 destination address */
  4288			if (usr_ip4_spec->ip4dst == htonl(0xFFFFFFFF))
  4289				new_mask |= I40E_L3_DST_MASK;
  4290			else if (!usr_ip4_spec->ip4dst)
  4291				new_mask &= ~I40E_L3_DST_MASK;
  4292			else
  4293				return -EOPNOTSUPP;
  4294	
  4295			/* First 4 bytes of L4 header */
  4296			if (usr_ip4_spec->l4_4_bytes == htonl(0xFFFFFFFF))
  4297				new_mask |= I40E_L4_SRC_MASK | I40E_L4_DST_MASK;
  4298			else if (!usr_ip4_spec->l4_4_bytes)
  4299				new_mask &= ~(I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
  4300			else
  4301				return -EOPNOTSUPP;
  4302	
  4303			/* Filtering on Type of Service is not supported. */
  4304			if (usr_ip4_spec->tos)
  4305				return -EOPNOTSUPP;
  4306	
  4307			/* Filtering on IP version is not supported */
  4308			if (usr_ip4_spec->ip_ver)
  4309				return -EINVAL;
  4310	
  4311			/* Filtering on L4 protocol is not supported */
  4312			if (usr_ip4_spec->proto)
  4313				return -EINVAL;
  4314	
  4315			break;
  4316		case IPV6_USER_FLOW:
  4317			usr_ip6_spec = &fsp->m_u.usr_ip6_spec;
  4318	
  4319			/* Check if user provided IPv6 source address. */
  4320			if (ipv6_addr_equal((struct in6_addr *)&usr_ip6_spec->ip6src,
  4321					    (struct in6_addr *)&ipv6_full_mask))
  4322				new_mask |= I40E_L3_V6_SRC_MASK;
  4323			else if (ipv6_addr_any((struct in6_addr *)
  4324					       &usr_ip6_spec->ip6src))
  4325				new_mask &= ~I40E_L3_V6_SRC_MASK;
  4326			else
  4327				return -EOPNOTSUPP;
  4328	
  4329			/* Check if user provided destination address. */
  4330			if (ipv6_addr_equal((struct in6_addr *)&usr_ip6_spec->ip6dst,
  4331					    (struct in6_addr *)&ipv6_full_mask))
  4332				new_mask |= I40E_L3_V6_DST_MASK;
  4333			else if (ipv6_addr_any((struct in6_addr *)
  4334					       &usr_ip6_spec->ip6src))
  4335				new_mask &= ~I40E_L3_V6_DST_MASK;
  4336			else
  4337				return -EOPNOTSUPP;
  4338	
  4339			if (usr_ip6_spec->l4_4_bytes == htonl(0xFFFFFFFF))
  4340				new_mask |= I40E_L4_SRC_MASK | I40E_L4_DST_MASK;
  4341			else if (!usr_ip6_spec->l4_4_bytes)
  4342				new_mask &= ~(I40E_L4_SRC_MASK | I40E_L4_DST_MASK);
  4343			else
  4344				return -EOPNOTSUPP;
  4345	
  4346			/* Filtering on Traffic class is not supported. */
  4347			if (usr_ip6_spec->tclass)
  4348				return -EOPNOTSUPP;
  4349	
  4350			/* Filtering on L4 protocol is not supported */
  4351			if (usr_ip6_spec->l4_proto)
  4352				return -EINVAL;
  4353	
  4354			break;
  4355		default:
  4356			return -EOPNOTSUPP;
  4357		}
  4358	
  4359		/* First, clear all flexible filter entries */
  4360		new_mask &= ~I40E_FLEX_INPUT_MASK;
  4361	
  4362		/* If we have a flexible filter, try to add this offset to the correct
  4363		 * flexible filter PIT list. Once finished, we can update the mask.
  4364		 * If the src_offset changed, we will get a new mask value which will
  4365		 * trigger an input set change.
  4366		 */
  4367		if (userdef->flex_filter) {
  4368			struct i40e_flex_pit *l3_flex_pit = NULL, *flex_pit = NULL;
  4369	
  4370			/* Flexible offset must be even, since the flexible payload
  4371			 * must be aligned on 2-byte boundary.
  4372			 */
  4373			if (userdef->flex_offset & 0x1) {
  4374				dev_warn(&pf->pdev->dev,
  4375					 "Flexible data offset must be 2-byte aligned\n");
  4376				return -EINVAL;
  4377			}
  4378	
  4379			src_offset = userdef->flex_offset >> 1;
  4380	
  4381			/* FLX_PIT source offset value is only so large */
  4382			if (src_offset > I40E_MAX_FLEX_SRC_OFFSET) {
  4383				dev_warn(&pf->pdev->dev,
  4384					 "Flexible data must reside within first 64 bytes of the packet payload\n");
  4385				return -EINVAL;
  4386			}
  4387	
  4388			/* See if this offset has already been programmed. If we get
  4389			 * an ERR_PTR, then the filter is not safe to add. Otherwise,
  4390			 * if we get a NULL pointer, this means we will need to add
  4391			 * the offset.
  4392			 */
  4393			flex_pit = i40e_find_flex_offset(&pf->l4_flex_pit_list,
  4394							 src_offset);
  4395			if (IS_ERR(flex_pit))
  4396				return PTR_ERR(flex_pit);
  4397	
  4398			/* IP_USER_FLOW filters match both L4 (ICMP) and L3 (unknown)
  4399			 * packet types, and thus we need to program both L3 and L4
  4400			 * flexible values. These must have identical flexible index,
  4401			 * as otherwise we can't correctly program the input set. So
  4402			 * we'll find both an L3 and L4 index and make sure they are
  4403			 * the same.
  4404			 */
  4405			if (flex_l3) {
  4406				l3_flex_pit =
  4407					i40e_find_flex_offset(&pf->l3_flex_pit_list,
  4408							      src_offset);
  4409				if (IS_ERR(l3_flex_pit))
  4410					return PTR_ERR(l3_flex_pit);
  4411	
  4412				if (flex_pit) {
  4413					/* If we already had a matching L4 entry, we
  4414					 * need to make sure that the L3 entry we
  4415					 * obtained uses the same index.
  4416					 */
  4417					if (l3_flex_pit) {
  4418						if (l3_flex_pit->pit_index !=
  4419						    flex_pit->pit_index) {
  4420							return -EINVAL;
  4421						}
  4422					} else {
  4423						new_flex_offset = true;
  4424					}
  4425				} else {
  4426					flex_pit = l3_flex_pit;
  4427				}
  4428			}
  4429	
  4430			/* If we didn't find an existing flex offset, we need to
  4431			 * program a new one. However, we don't immediately program it
  4432			 * here because we will wait to program until after we check
  4433			 * that it is safe to change the input set.
  4434			 */
  4435			if (!flex_pit) {
  4436				new_flex_offset = true;
  4437				pit_index = i40e_unused_pit_index(pf);
  4438			} else {
  4439				pit_index = flex_pit->pit_index;
  4440			}
  4441	
  4442			/* Update the mask with the new offset */
  4443			new_mask |= i40e_pit_index_to_mask(pit_index);
  4444		}
  4445	
  4446		/* If the mask and flexible filter offsets for this filter match the
  4447		 * currently programmed values we don't need any input set change, so
  4448		 * this filter is safe to install.
  4449		 */
  4450		if (new_mask == current_mask && !new_flex_offset)
  4451			return 0;
  4452	
  4453		netif_info(pf, drv, vsi->netdev, "Input set change requested for %s flows:\n",
  4454			   i40e_flow_str(fsp));
  4455		i40e_print_input_set(vsi, current_mask, new_mask);
  4456		if (new_flex_offset) {
  4457			netif_info(pf, drv, vsi->netdev, "FLEX index %d: Offset -> %d",
  4458				   pit_index, src_offset);
  4459		}
  4460	
  4461		/* Hardware input sets are global across multiple ports, so even the
  4462		 * main port cannot change them when in MFP mode as this would impact
  4463		 * any filters on the other ports.
  4464		 */
  4465		if (pf->flags & I40E_FLAG_MFP_ENABLED) {
  4466			netif_err(pf, drv, vsi->netdev, "Cannot change Flow Director input sets while MFP is enabled\n");
  4467			return -EOPNOTSUPP;
  4468		}
  4469	
  4470		/* This filter requires us to update the input set. However, hardware
  4471		 * only supports one input set per flow type, and does not support
  4472		 * separate masks for each filter. This means that we can only support
  4473		 * a single mask for all filters of a specific type.
  4474		 *
  4475		 * If we have preexisting filters, they obviously depend on the
  4476		 * current programmed input set. Display a diagnostic message in this
  4477		 * case explaining why the filter could not be accepted.
  4478		 */
  4479		if (*fdir_filter_count) {
  4480			netif_err(pf, drv, vsi->netdev, "Cannot change input set for %s flows until %d preexisting filters are removed\n",
  4481				  i40e_flow_str(fsp),
  4482				  *fdir_filter_count);
  4483			return -EOPNOTSUPP;
  4484		}
  4485	
  4486		i40e_write_fd_input_set(pf, index, new_mask);
  4487	
  4488		/* IP_USER_FLOW filters match both IPv4/Other and IPv4/Fragmented
  4489		 * frames. If we're programming the input set for IPv4/Other, we also
  4490		 * need to program the IPv4/Fragmented input set. Since we don't have
  4491		 * separate support, we'll always assume and enforce that the two flow
  4492		 * types must have matching input sets.
  4493		 */
  4494		if (index == I40E_FILTER_PCTYPE_NONF_IPV4_OTHER)
  4495			i40e_write_fd_input_set(pf, I40E_FILTER_PCTYPE_FRAG_IPV4,
  4496						new_mask);
  4497	
  4498		/* Add the new offset and update table, if necessary */
  4499		if (new_flex_offset) {
  4500			err = i40e_add_flex_offset(&pf->l4_flex_pit_list, src_offset,
  4501						   pit_index);
  4502			if (err)
  4503				return err;
  4504	
  4505			if (flex_l3) {
  4506				err = i40e_add_flex_offset(&pf->l3_flex_pit_list,
  4507							   src_offset,
  4508							   pit_index);
  4509				if (err)
  4510					return err;
  4511			}
  4512	
  4513			i40e_reprogram_flex_pit(pf);
  4514		}
  4515	
  4516		return 0;
  4517	}
  4518	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27644 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200811/85107cc8/attachment-0001.bin>
