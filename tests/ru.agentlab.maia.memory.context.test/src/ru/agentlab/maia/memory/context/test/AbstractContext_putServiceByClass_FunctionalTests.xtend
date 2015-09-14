package ru.agentlab.maia.memory.context.test

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.junit.Assume.*
import static org.mockito.Mockito.*
import static ru.agentlab.maia.memory.context.test.ServiceRegistration.*

@RunWith(Parameterized)
class AbstractContext_putServiceByClass_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IMaiaContext context, ServiceRegistration contextServices, ServiceRegistration parentServices) {
		super(context, contextServices, parentServices)
	}

	@Test
	def void getKeySet_increaseSize_whenKeyNoInContext_whenValidArgs() {
		assumeKeyNotInContext
		val before = context.keySet.size

		invokeWithValidArgs

		assertThat(context.keySet.size - before, equalTo(1))
	}

	@Test
	def void getKeySet_increaseSize_whenKeyNoInContext_whenNullService() {
		assumeKeyNotInContext
		val before = context.keySet.size

		invokeWithNullService

		assertThat(context.keySet.size - before, equalTo(1))
	}

	@Test
	def void getKeySet_unchangeSize_whenKeyInContext_whenValidArgs() {
		assumeKeyInContext
		val before = context.keySet.size

		invokeWithValidArgs

		assertThat(context.keySet.size, equalTo(before))
	}

	@Test
	def void getKeySet_unchangeSize_whenKeyInContext_whenNullService() {
		assumeKeyInContext
		val before = context.keySet.size

		invokeWithNullService

		assertThat(context.keySet.size, equalTo(before))
	}

	@Test
	def void getKeySet_containKey_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.keySet, hasItem(KEY_STRING_VALID))
	}

	@Test
	def void getKeySet_containKey_whenNullService() {
		invokeWithNullService

		assertThat(context.keySet, hasItem(KEY_STRING_VALID))
	}

	@Test
	def void getProviderByString_returnNull_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProvider(KEY_STRING_VALID), nullValue)
	}

	@Test
	def void getProviderByString_returnNull_whenNullService() {
		invokeWithNullService

		assertThat(context.getProvider(KEY_STRING_VALID), nullValue)
	}

	@Test
	def void getProviderByClass_returnNull_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getProvider(KEY_CLASS_VALID), nullValue)
	}

	@Test
	def void getProviderByClass_returnNull_whenNullService() {
		invokeWithNullService

		assertThat(context.getProvider(KEY_CLASS_VALID), nullValue)
	}

	@Test
	def void getServiceByString_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getService(KEY_STRING_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceByString_returnNull_whenNullService() {
		invokeWithNullService

		assertThat(context.getService(KEY_STRING_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getServiceByClass_returnValue_whenValidArgs() {
		invokeWithValidArgs

		assertThat(context.getService(KEY_CLASS_VALID), equalTo(SERVICE_VALID))
	}

	@Test
	def void getServiceByClass_returnNull_whenNullService() {
		invokeWithNullService

		assertThat(context.getService(KEY_CLASS_VALID), equalTo(SERVICE_NULL))
	}

	@Test
	def void getUuid_unchangeValue_whenValidArgs() {
		val before = context.uuid

		invokeWithValidArgs

		assertThat(context.uuid, equalTo(before))
	}

	@Test
	def void getUuid_unchangeValue_whenNullService() {
		val before = context.uuid

		invokeWithNullService

		assertThat(context.uuid, equalTo(before))
	}

	@Test
	def void getParent_unchangeValue_whenValidArgs() {
		val before = context.parent

		invokeWithValidArgs

		assertThat(context.parent, equalTo(before))
	}

	@Test
	def void getParent_unchangeValue_whenNullService() {
		val before = context.parent

		invokeWithNullService

		assertThat(context.parent, equalTo(before))
	}

	@Test
	def void getChilds_unchangeValue_whenValidArgs() {
		val before = context.childs

		invokeWithValidArgs

		assertArrayEquals(before, context.childs)
	}

	@Test
	def void getChilds_unchangeValue_whenNullService() {
		val before = context.childs

		invokeWithNullService

		assertArrayEquals(before, context.childs)
	}

	@Test
	def void self_notInteractWithParent_whenValidArgs() {
		invokeWithValidArgs

		verifyZeroInteractions(parent)
	}

	@Test
	def void self_notInteractWithParent_whenNullService() {
		invokeWithNullService

		verifyZeroInteractions(parent)
	}

	@Test(expected=NullPointerException)
	def void self_throw_whenNullString() {
		invokeWithNullString
	}

	@Test(expected=NullPointerException)
	def void self_throw_whenNullArgs() {
		invokeWithNullArgs
	}

	def private assumeNoInContext() {
		assumeThat(contextServices, anyOf(
			equalTo(NONE),
			equalTo(SERVICE_BY_STRING),
			equalTo(PROVIDER_BY_STRING)
		))
	}

	def private assumeInContext() {
		assumeThat(contextServices, anyOf(
			equalTo(SERVICE_BY_CLASS),
			equalTo(PROVIDER_BY_CLASS)
		))
	}
	
	def private assumeKeyNotInContext(){
		assumeThat(contextServices, anyOf(
			equalTo(NONE)
		))
	}
	
	def private assumeKeyInContext(){
		assumeThat(contextServices, anyOf(
			equalTo(SERVICE_BY_CLASS),
			equalTo(PROVIDER_BY_CLASS),
			equalTo(SERVICE_BY_STRING),
			equalTo(PROVIDER_BY_STRING)
		))
	}

	def private void invokeWithValidArgs() {
		context.putService(KEY_CLASS_VALID, SERVICE_VALID)
	}

	def private void invokeWithNullService() {
		context.putService(KEY_CLASS_VALID, SERVICE_NULL)
	}

	def private void invokeWithNullString() {
		context.putService(KEY_CLASS_NULL, SERVICE_VALID)
	}

	def private void invokeWithNullArgs() {
		context.putService(KEY_CLASS_NULL, SERVICE_NULL)
	}

}